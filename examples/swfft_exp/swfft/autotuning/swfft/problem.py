import numpy as np
from numpy import abs, cos, exp, mean, pi, prod, sin, sqrt, sum
from autotune import TuningProblem
from autotune.space import *
import os
import sys
import time
import json
import math

import ConfigSpace as CS
import ConfigSpace.hyperparameters as CSH
from skopt.space import Real, Integer, Categorical

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(1, os.path.dirname(HERE)+ '/plopper')
from plopper import Plopper

cs = CS.ConfigurationSpace(seed=1234)
# number of threads
p0= CSH.OrdinalHyperparameter(name='p0', sequence=['8','16','32','64','128','256'], default_value='64')
# omp placement
p1= CSH.CategoricalHyperparameter(name='p1', choices=['cores','threads','sockets'], default_value='cores')
# OMP_PROC_BIND
p2= CSH.CategoricalHyperparameter(name='p2', choices=['close','spread','master'], default_value='close')
# OMP_SCHEDULE
p3= CSH.CategoricalHyperparameter(name='p3', choices=['dynamic','static'], default_value='static')

cs.add_hyperparameters([p0, p1, p2, p3])

# problem space
task_space = None

input_space = cs

output_space = Space([
     Real(0.0, inf, name="time")
])

dir_path = os.path.dirname(os.path.realpath(__file__))
kernel_idx = dir_path.rfind('/')
kernel = dir_path[kernel_idx+1:]
obj = Plopper(dir_path+'/mmp.cpp',dir_path)

x1=['p0','p1','p2','p3']

def myobj(point: dict):

  def plopper_func(x):
    x = np.asarray_chkfinite(x)  # ValueError if any NaN or Inf
    value = [point[x1[0]],point[x1[1]],point[x1[2]],point[x1[3]]]
    print('VALUES:',point[x1[0]])
    params = ["P0","P1","P2","P3"]

    result = obj.findRuntime(value, params)
    return result

  x = np.array([point[f'p{i}'] for i in range(len(point))])
  results = plopper_func(x)
  print('OUTPUT:%f',results)

  return results

Problem = TuningProblem(
    task_space=None,
    input_space=input_space,
    output_space=output_space,
    objective=myobj,
    constraints=None,
    model=None
    )
