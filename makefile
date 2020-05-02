testupload: dist/fitting2d*.tar.gz
	python3 -m twine upload --repository testpypi dist/* && touch testupload

testinstall: testupload
	python3 -m pip install --index-url https://test.pypi.org/simple/ --no-deps --upgrade fitting2d

upload: dist
	python3 -m twine upload dist/* && touch upload

dist/fitting2d*.tar.gz: setup.py setup.cfg fitting2d/__init__.py
	python3 setup.py sdist bdist_wheel

clean:
	rm -rm dist
