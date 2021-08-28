
test-koa:
	node ./plain_server/koa.js & echo "kill $$!" > .temp_kill.sh
	@sleep 1
	ab -n 100000 -c 1000 http://localhost:3000/ > ./plain_server/koa.log
	@sh ./.temp_kill.sh || true
	@rm ./.temp_kill.sh || true

test-connect:
	node ./plain_server/connect.js & echo "kill $$!" > .temp_kill.sh
	@sleep 1
	ab -n 100000 -c 1000 http://localhost:3000/ > ./plain_server/connect.log
	@sh ./.temp_kill.sh || true
	@rm ./.temp_kill.sh || true

test-express:
	node ./plain_server/express.js & echo "kill $$!" > .temp_kill.sh
	@sleep 1
	ab -n 100000 -c 1000 http://localhost:3000/ > ./plain_server/express.log
	@sh ./.temp_kill.sh || true
	@rm ./.temp_kill.sh || true

test-restify:
	node ./plain_server/restify.js & echo "kill $$!" > .temp_kill.sh
	@sleep 1
	ab -n 100000 -c 1000 http://localhost:3000/ > ./plain_server/restify.log
	@sh ./.temp_kill.sh || true
	@rm ./.temp_kill.sh || true

clean_up:
	@sh ./.temp_kill.sh || true
	@rm ./.temp_kill.sh || true

test-all: test-koa test-connect test-express test-restify
	@echo Requests per second:
	@grep -E 'Requests per second:' ./plain_server/*.log
	@echo Done

