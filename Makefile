test:
	bundle exec rspec

test-feature:
	bundle exec rspec --tag type:feature

watch-unit:
	bundle exec guard

test-logs:
	tail -f log/test.log