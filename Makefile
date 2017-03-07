# Export environment variables from .env file
ifneq ("$(wildcard .env)","")
sinclude .env
export $(shell [ -f .env ] && sed 's/=.*//' .env)
endif

install:
	@if [ ! -e ${HOME}/terraform/terraform ]; then \
		curl -fSL "https://releases.hashicorp.com/terraform/0.8.8/terraform_0.8.8_linux_amd64.zip" -o terraform.zip; \
		unzip -o terraform.zip -d ${HOME}/terraform; \
		rm -f terraform.zip; \
	fi
	sudo ln -s -f ${HOME}/terraform/terraform /usr/bin/terraform

terraform-plan:
	terraform plan \
		-state=./.terraform/${ENV}.tfstate \
		-var-file=./terraform/${ENV}.tfvars \
		./terraform

terraform-apply:
	terraform apply \
		-state=./.terraform/${ENV}.tfstate \
		-var-file=./terraform/${ENV}.tfvars \
		./terraform
