# GPTune Copyright (c) 2019, The Regents of the University of California,
# through Lawrence Berkeley National Laboratory (subject to receipt of any
# required approvals from the U.S.Dept. of Energy) and the University of
# California, Berkeley.  All rights reserved.
#
# If you have questions about your rights to use or distribute this software,
# please contact Berkeley Lab's Intellectual Property Office at IPO@lbl.gov.
#
# NOTICE. This Software was developed under funding from the U.S. Department
# of Energy and the U.S. Government consequently retains certain rights.
# As such, the U.S. Government has been granted for itself and others acting
# on its behalf a paid-up, nonexclusive, irrevocable, worldwide license in
# the Software to reproduce, distribute copies to the public, prepare
# derivative works, and perform publicly and display publicly, and to permit
# other to do so.
#

# Crowd-tune API

def QueryFunctionEvaluations(crowd_tune_api_key:str=None,
        tuning_problem_name:str=None,
        problem_space:dict={}):

    import requests
    import json

    # GPTune history database
    crowd_repo_download_url = "http://gptune.lbl.gov/repo/direct-download/"
    crowd_repo_upload_url = "http://gptune.lbl.gov/repo/direct-upload/"
    ## debug
    #crowd_repo_download_url = "http://127.0.0.1:8000/repo/direct-download/"
    #crowd_repo_upload_url = "http://127.0.0.1:8000/repo/direct-upload/"

    function_evaluations_downloaded = {}

    r = requests.get(url = crowd_repo_download_url,
            headers={"x-api-key":crowd_tune_api_key},
            params={"tuning_problem_name":tuning_problem_name,
                "problem_space":problem_space},
            verify=False)

    if r.status_code == 200:
        function_evaluations_downloaded = json.loads(r.text)["perf_data"]
    else:
        print ("request status_code: ", r.status_code)

    return function_evaluations_downloaded

def QueryBestParameter(crowd_tune_api_key:str=None,
        tuning_problem_name:str=None,
        problem_space:dict={}):

    import requests
    import json

    # GPTune history database
    crowd_repo_download_url = "http://gptune.lbl.gov/repo/direct-download/"
    crowd_repo_upload_url = "http://gptune.lbl.gov/repo/direct-upload/"
    ## debug
    #crowd_repo_download_url = "http://127.0.0.1:8000/repo/direct-download/"
    #crowd_repo_upload_url = "http://127.0.0.1:8000/repo/direct-upload/"

    return {}

def QuerySurrogateModels(crowd_tune_api_key:str=None,
        tuning_problem_name:str=None,
        problem_space:dict={}):

    import requests
    import json

    # GPTune history database
    crowd_repo_download_url = "http://gptune.lbl.gov/repo/direct-download/"
    crowd_repo_upload_url = "http://gptune.lbl.gov/repo/direct-upload/"
    # debug
    crowd_repo_download_url = "http://127.0.0.1:8000/repo/direct-download/"
    crowd_repo_upload_url = "http://127.0.0.1:8000/repo/direct-upload/"

    return

def SensitivityAnalysisFromCrowds(crowd_tune_api_key:str=None,
        tuning_problem_name:str=None,
        problem_space:dict=None,
        modeler:str="Model_GPy_LCM",
        method:str="Sobol",
        input_task:list=[],
        num_samples:int=1000):

    function_evaluations = QueryFunctionEvaluations(
            crowd_tune_api_key = crowd_tune_api_key,
            tuning_problem_name = tuning_problem_name,
            problem_space = problem_space)

    import gptune
    return gptune.SensitivityAnalysis(
            problem_space = problem_space,
            modeler = modeler,
            method = method,
            input_task = input_task,
            function_evaluations = function_evaluations
            )

