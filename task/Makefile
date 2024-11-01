all::

# prevent attempt to download centralised config
PIPELINE_CONFIG_FILES=.dummy
init::; touch .dummy

include makerules/makerules.mk
include makerules/pipeline.mk
include makerules/datapackage.mk
include makerules/development.mk

OUTPUT_DIR=dataset
CSV=$(OUTPUT_DIR)/organisation.csv

first-pass::
	bin/download-organisation-datasets.py

second-pass:: $(CSV)

$(CSV):
	@rm -f $@
	mkdir -p $(OUTPUT_DIR)
	digital-land organisation-create --dataset-dir var/cache/organisation-collection/dataset/ --output-path $@

clean::
	rm -rf ./var

clobber::
	rm -rf ./var/cache/
	rm -rf $(CSV)

aws-build::
	aws batch submit-job --job-name organisation-$(shell date '+%Y-%m-%d-%H-%M-%S') --job-queue dl-batch-queue --job-definition dl-batch-def --container-overrides '{"environment": [{"name":"BATCH_FILE_URL","value":"https://raw.githubusercontent.com/digital-land/docker-builds/main/builder_run.sh"}, {"name" : "REPOSITORY","value" : "digital-land-builder"}]}'

push::
	aws s3 cp $(CSV) s3://organisation-data/dataset/organisation.csv

specification::
	# additional
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/issue-type.csv' > specification/issue-type.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/severity.csv' > specification/severity.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/cohort.csv' > specification/cohort.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/project.csv' > specification/project.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/project-organisation.csv' > specification/project-organisation.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/include-exclude.csv' > specification/include-exclude.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/role.csv' > specification/role.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/role-organisation.csv' > specification/role-organisation.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/role-organisation-rule.csv' > specification/role-organisation-rule.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/specification.csv' > specification/specification.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/specification-status.csv' > specification/specification-status.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/project-status.csv' > specification/project-status.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/provision.csv' > specification/provision.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/provision-rule.csv' > specification/provision-rule.csv
	curl -qfsL '$(SOURCE_URL)/specification/main/specification/provision-reason.csv' > specification/provision-reason.csv
