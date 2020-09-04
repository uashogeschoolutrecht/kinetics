# kinetics
This is the public repo to the R package with data and analysis code and graphs accompanying the publication of [Kartaram et al., 2020, Frontiers in Physiology](https://www.frontiersin.org/articles/10.3389/fphys.2020.01006/full). 

All materials in this repository are published under the CC-BY NC 4.0 licence. That means that you can use it, but you are not allowed to make money out of it.

There are a number of ways that this R package can be used. The package can be cloned or forked directly from github 
at github.com/uashogeschoolutrecht/kinetics.

It can be installed directly in R from Github using the remotes R package.

Users familiar with Docker can deploy the package in an isolated RStudio Server Docker Container and use the package code from these.
The big advantage of this last approach is that a container is lightweigth and has all the proper dependencies already installed.
 
## To install the package in R
Run the following commands in your R session

`install.packages("remotes")`
`remotes::install_github("uashogeschoolutrecht/kinetics")`

## To run the Docker container
You will need to have a working installation of Docker and Git installed on your system. I use Microsoft Visual Studio Code.
The Docker image povided in this package is build on top of the stable relaeses of RStudio Server Docker images provided in the DockerHub Rocker repository. The image here is based on the rocker/verse image that contains all the tidyverse and package development tools and also comes with publication tools to build publications and documents from e.g. RMarkdown. 

Open a new Terminal and run the following commands
Be sure to run these command from inside the directory containing the repository contents
Getting a copy of the repository contents can be achieved by running in Terminal:

`git clone https://github.com/uashogeschoolutrecht/kinetics

To build the image:

`docker build . -t kinetics_container`

`docker run -e PASSWORD=<provide_a_password_here> -p 8787:8787 -d --rm kinetics_container`

Open http://localhost:8787 and login using 'rstudio' as username and your chosen password.

Run browseVignettes(package = "kinetics") in the R-Console or open the Rmd file in `./vignettes`
Raw data is stored in the `./data-raw` folder. Images in the `./inst` folder.

http://localhost:8787/help/library/kinetics/doc/kinetics.html
docker ps -a # List all running containers
docker stop <CONTAINER ID> # or, <CONTAINER_NAME> - Stop the container"# kinetics" 

We appreciate pull requests.
