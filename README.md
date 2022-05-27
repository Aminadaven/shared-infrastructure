[![Publish scratch-jre](https://github.com/Aminadaven/shared-infrastructure/actions/workflows/publish-scratch-jre.yml/badge.svg)](https://github.com/Aminadaven/v/actions/workflows/publish-scratch-jre.yml)

# Shared Infrastructure

## Description
This repository hosts all the shared infrastructure needed for my java spring boot services. 

## Contents
 - Shared pipeline to be called from all projects.
 - Scratch-jre base images which is pushed to my registry on a weekly basis.
 - Examples for different subjects and cases.
 - Test dir to serve as a test lab for base images.
 - Gradlew - Gradle Wrapper for convenience (7.4.2).

### scratch-jre:
Here are the dockerfiles and the .sh script needed for the image tags.

The tags are based on those variants:
- Java version: 17 or 18
- JRE size: min or max
- Font support: -fonts

_For more information about the difference between min and max images,
see [MINIMAL-JAVA-MODULES.md](MINIMAL-JAVA-MODULES.md)._

Pull commands:
 - `docker pull aminadaven/scratch-jre:{size}-{version}`
 - `docker pull aminadaven/scratch-jre:{size}-{version}-fonts`

### examples:
Examples and templates to use with new projects regarding docker, gradle and deployments.

1. dockerfiles
2. gradle
3. local_development
4. workflows
5. single-files

### .github/workflows:
The workflows activated in the repo. 
Currently, there is the shared pipeline to be called from the projects, 
and also a workflow to create and update weekly the scratch-jre images.

#### Images Location
The images are pushed to dockerhub, to my private registry: **aminadaven/scratch-jre**

### gradlew:
Hosts gradle wrapper that can be copied to projects. Version 7.4.2 .

### test:
Serves as a test lab for base images. 
Create a java file with the action to try to perform, 
update test.bat with required args and start it to see results. 
