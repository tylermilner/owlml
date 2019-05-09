# Setting Up Your Python Environment

If you aren't familiar with Python (like me), you can setup your Python environment by following the instructions [here](https://hackercodex.com/guide/python-development-environment-on-mac-osx/).

## Installing Project Dependencies

Once you've got `virtualenv` installed, create an environment for this project.

```bash
virtualenv venv
```

Next, activate the project's virtual environment so that you can install the required dependencies.

```bash
source venv/bin/activate
```

`(venv)` should now appear in the terminal prompt. Install OpenCV using `pip`.

```bash
pip install opencv-python
```
