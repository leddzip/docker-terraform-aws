image_name = leddzip/terraform-aws
tag = $$(bash ./build-scripts/build-env-prefix.sh)

print:
	@echo $(tag)
