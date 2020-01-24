# go-lambda-template

This is a [Cookiecutter](https://github.com/audreyr/cookiecutter) template to create a Go AWS Lambda with Terraform deployment and infrastructure.

It is important to note that you should not try to `git clone` this project but use `cookiecutter` CLI instead as ``{{cookiecutter.project_slug}}`` will be rendered based on your input and therefore all variables and files will be rendered properly.

## Requirements

Install `cookiecutter` command line: 

**Pip users**:

* `pip install cookiecutter`

**Homebrew users**:

* `brew install cookiecutter`

**Windows or Pipenv users**:

* `pipenv install cookiecutter`

**NOTE**: [`Pipenv`](https://github.com/pypa/pipenv) is the new and recommended Python packaging tool that works across multiple platforms and makes Windows a first-class citizen.

## Usage

Generate a new AWS Go Lambda: `cookiecutter gh:flow-lab/go-lambda-template` (or if you want to authenticate with ssh: `cookiecutter git+ssh://git@github.com/flow-lab/go-lambda-template)`.

You'll be prompted a few questions to help this cookiecutter template to scaffold this project and after its completed you should see a new folder at your current path with the name of the project you gave as input.

After project has been generated, cd into it and push to github (make sure you have created the repository first):

```
$ cd <project-name>
$ git init .
$ git remote add origin git@github.com:<github-user>/<project-name>.git
$ git add . && git commit -m 'Initial commit' && git push origin master
```

**NOTE**: After you understand how cookiecutter works (cookiecutter.json, mainly), you can fork this repo and apply your own mechanisms to accelerate your development process and this can be followed for any programming language and OS.

## Options

Option | Description
------------------------------------------------- | ---------------------------------------------------------------------------------
`project_name`              | Project name
`project_slug`              | Project slug
`github_user`               | The GitHub user 
`project_short_description` | The project short description
`lambda_name`               | Lambda name
`aws_region`                | The aws region for deployment
`terraform_state_s3`        | The terraform state s3 bucket
`terraform_version`         | The terraform version

# Credits

* This project has been generated with [Cookiecutter](https://github.com/audreyr/cookiecutter)


License
-------
[![License: MPL 2.0](https://img.shields.io/badge/License-MPL%202.0-brightgreen.svg)](https://opensource.org/licenses/MPL-2.0)
