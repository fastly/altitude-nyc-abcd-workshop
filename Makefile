install:
	@if [ ! -e ${HOME}/terraform/terraform ]; then \
		curl -fSL "https://releases.hashicorp.com/terraform/0.8.8/terraform_0.8.8_linux_amd64.zip" -o terraform.zip; \
		unzip -o terraform.zip -d ${HOME}/terraform; \
		rm -f terraform.zip; \
	fi
	sudo ln -s -f ${HOME}/terraform/terraform /usr/bin/terraform
