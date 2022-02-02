# Anaconda Navigation

## Create new environment on Anaconda
- Option (1): `conda create -n env_name python:3.9`
- Option (2): Go into Anaconda Navigator to create an environment
> **ERROR SOLVER** Sometimes, anaconda behaves strangely by creating environment in twos. E.g. `conda create -n new_env python=3.7` would give two environments named new_env! To mitigate this - First, check that environment variables were set correctly! Following that, the error can be resolved by executing these on anaconda prompt: `conda update conda`, `conda update anaconda-navigator` and `conda update navigator-updater`

## Activate Environment
- `conda activate new_env` to activate the environment named new_env.
- `conda env list` to check that you are in the environment activated.

## Package Install
- From here onwards, all the commands run is executed in the virtual environment only.
  - E.g. `pip install numpy` or `conda install numpy` here will install the numpy package in the virtual environment.
  - The packages installed in the virtual environment stays there permanently i.e. you don't have to re-install everything when you re-activate the environment again!
  - To install multiple packages in the virtual environment in one go, make use of requirement.txt
    - `pip install -r work/requirements.txt` to download the packages specified in requirements.txt
    - `pip freeze > work/requirements_windows.txt` to update requirements.txt
  - Typing `python` and entering the command will enable use to run python scripts in the environment.
- Check what packages are in the environment by executing `conda list`

## Other important commands to help navigate the cmd
- `cd` to enter a directory
- `cd..` to exit a directory
- `dir` to find current directory
- `cls` to clear cmd
- Ctrl + c to interrupt
- Ctrl + d is an end-of-file signal, usually used to exit current terminal

Lastly, [here's](https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf) a useful cheatsheet for reference.

*fin*
