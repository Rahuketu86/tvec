SRC = $(wildcard ./*.ipynb)

all: tvec docs

tvec: $(SRC)
	nbdev_build_lib
	touch tvec

docs_serve: docs
	cd docs && bundle exec jekyll serve --host 0.0.0.0

docs: $(SRC)
	nbdev_build_docs
	touch docs

test:
	nbdev_test_nbs

release: pypi
	nbdev_bump_version

pypi: dist
	twine upload --repository pypi dist/*

dist: clean
	python setup.py sdist bdist_wheel

clean:
	rm -rf dist