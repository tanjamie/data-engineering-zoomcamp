# A Simple & Short Introduction to Docker

## Why Docker?
### Advantage #1: Containerization & Isolation
Docker packages our code into multiple **containers**, which are **isolated** from one and the other. This means each container won't interfere with another container's code and execution. Thus, other than the source code, every container has the os, libraries and other dependencies that is required to run the source code independently in the container environment. Multiple docker containers can be set up in a local machine and interact with each other.

### Advantage #2: Reproducibility
Another advantage that Docker has is reproducibility. We can create a snapshot of a container called image. When executing it on another container, the image will run as it is in the original container i.e. ability to create and reuse docker images in different environments. This is especially useful in collaborative developing, because previously developed images can be reused by other collaborators.

### Implied Advantages from #1 & #2
- Enables local experiments (within each containers) i.e. unit testing
- Enables integration tests (CI/CD) i.e. check that independently developed units of software work as intended when they are connected to each other
- Running pipelines on the cloud i.e. take image and run on cloud like AWS Batch and Kubernetes jobs
- Use Spark in Docker
- Use Severless (AWS Lamda, Google Functions) to define environment with Docker images


## Getting Started - Creating a simple "data pipeline" in Docker
### Install Docker
- Install [here](https://docs.docker.com/get-docker/)
- Add path to Docker's bin into your user's environment variables

### Explore Docker
> Tool: Git Bash [Why?: `MINGW64` enables use of linux commands otherwise not available to windows command line]

1. Check if Docker is properly installed
    - Execute `docker run hello-world`. Behind the scenes, docker searches for the image named `hello-world` from Docker Hub (where all images are stored) if it is not available on your local machine, downloads the image and runs it.
2. Try something more ambitious next
    - Run `docker run -it ubuntu bash`. Here docker pulls and runs ubuntu interactively, then executes command `bash` in the image.    
        > **ERROR SOLVER** >> If this throws `the input device is not a TTY error` consider running `winpty docker run -it ubuntu bash` instead, and make this adjustment for all your docker command in `-it` mode i.e. interactive mode.
    - Run `ls` to inspect items in the container. Then `rm -rf / --no-preserve-root` to delete everything in the container and see the changes using `ls` again.
    - `exit` or `ctrl + d` to exit the container, go back into the container using `docker run -it ubuntu bash`, and see that we have everything again with `ls`!
        > [Take away: Observed persistance of contents in an image]
3. Run python in docker image
    - Pull python image and run it interactively with `winpty docker run -it python:3.9`, where `:3.9` is a tag specifying the version of python to use. This enables python code execution i.e. from here on, python code can be understood in your command line
    - Do `print("hello world")` then `import pandas` which throws `ModuleNotFoundError` (yes, of course, because we haven't installed pandas in the image, so let's do that)
    - Exit python then run `winpty docker run -it --entrypoint=bash python:3.9` where entrypoint tells Git Bash what to executed exactly when we run the container. Here, we are entering the bash command line within the python container.
    - Run `pip install pandas` to install package in the specified python:3.9 docker container
    - Execute `python` to indicate to Git Bash that the following commands are python scripts then do `import pandas` then `pandas.__version__`
    - Exit the container and re-enter with `winpty docker run -it --entrypoint=bash python:3.9` again
    - Execute `python` and `import pandas` again, you will encounter *ModuleNotFoundError* again
        > [Take away: Images persist, but that also means any changes madeon top of it will not be saved. Recall, `python:3.9` image is the original image from Docker Hub, so that container will not have pandas. To retain changes, a new image needs to be written using Dockerfile specifying changes]

### Write a Dockerfile
1. Enter the directory you want to work in, open an editor then create a file named *Dockerfile*. Some useful command line commands:
    - `pwd` shows current directory
    - `cd` means go into the specified directory
    - `cd ..` exits the current directory
    - `code .` opens up default editor
2. Write instructions on Dockerfile to create a new image based on our own requirements i.e. with pandas
    ```
    # See full code and explanations in Dockerfile
    FROM python:3.9.1
    RUN pip install pandas
    ENTRYPOINT[ "bash" ]
    ```
    - Run `docker build -t test:pandas .` which builds a docker image, named test and tagged pandas, in current directory
    - To use the new image by running `winpty docker run -it test:pandas`, `python` then `import pandas`. You will see pandas being imported successfully!!
3. Check that image made is accessible by other files in the same container
    ```
    # See full code and explanations in *pipeline.py*
    import pandas as pd
    # some fancy stuff with pandas
    print(f'job finished successfully for day = f{day}'
    ```
    ```
    # Update Dockerfile to run pipeline.py in the new image container
    FROM python:3.9.1
    RUN pip install pandas
    WORKDIR /app
    COPY pipeline.py pipeline.py
    ENTRYPOINT[ "bash" , "pipeline.py" ]
    ```
    - Run `docker build -t test:pandas .` and this overwrites the previous `test:pandas`
    - Then, `winpty docker run -it test:pandas` and `pwd` to see current directory and `ls` showing `pipeline.py` in `\app`
    - Run `python pipeline.py` to run the file
4. Configure `pipeline.py` to accept arguments and make file run automatically when image runs
    ```
    # Update pipeline.py to accept arguments
    import sys
    import pandas as pd
    
    print(sys.argv)
    day = sys.argv[1]
    
    # some fancy stuff with pandas
    print(f'job finished successfully for day = {day}')
    ```
    ```
    # Update Dockerfile to run pipeline.py when image runs
    FROM python:3.9.1
    RUN pip install pandas
    WORKDIR /app
    COPY pipeline.py pipeline.py
    ENTRYPOINT [ "python", "pipeline.py" ]
    ```
    - Run `docker build -t test:pandas .` to build image and `winpty docker run -it test:pandas 2020-10-23 hello` to run scripts in container where *2020-10-23* and *hello* are arguments

*fin*
