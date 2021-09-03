check-variables:
ifndef FOLDER_ID
	$(error FOLDER_ID is not defined)
endif
ifndef YC_TOKEN
	$(error YC_TOKEN is not defined)
endif

build: check-variables
	packer build -var 'folder_id=${FOLDER_ID}' ./build.pkr.hcl
