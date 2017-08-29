.PHONY: clean install test deploy

clean:
	rm -rf dist/ node_modules/

install:
	npm install

test: install
	npm test

deploy: test clean
	npm install --production
	mkdir dist/
	cp lambda.js dist/
	-cp -r node_modules dist/
	pushd dist/
	zip -r skills-framework-test.zip *
	popd
	terraform init -force-copy -input=false
	terraform plan
	terraform apply
