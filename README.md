# ruby_jenkins_api_client
Docker image and helpers for working with jenkins_api_client gem

*Dockerfile* creates a docker image that has the jenkins_api_client gem installed.  You can use this image to run local ruby scripts that access a jenkins server.  The gem is not a trivial install, it requires building native extensions which don't always work so I found using a container to be easier than installing the right ruby and deps on various workstations.

*ruby_jenkins* can be installed or run locally an is just a helper to run the docker image.

*Makefile* just installs and removes ruby_jenkins

*example_list_jobs.rb* just shows the simple example of a ruby script to list the available jobs on a jenkins server.
