test:
	THEMIS_VIM=nvim THEMIS_ARGS="-e -s --headless" themis --exclude ./test/autoload/_test_data
	THEMIS_VIM=vim THEMIS_ARGS="-e -s" themis --exclude ./test/autoload/_test_data

start:
	./bin/gevdoc --exclude test/autoload/_test_data --externals test/autoload/_test_data/examples.vim
	./bin/gevdoc --exclude test/autoload/_test_data

doc:
	./bin/gevdoc --exclude test/autoload/_test_data

.PHONY: test
.PHONY: start
.PHONY: doc
