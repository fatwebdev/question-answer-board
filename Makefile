test:
	bundle exec rspec

test-logs:
	tail -f log/test.log