install:
	@make clean
	@make build
	@make up
	docker compose exec app composer create-project --prefer-dist "laravel/laravel=10.*" .
	docker compose exec app php artisan storage:link
	docker compose exec app chmod -R 777 storage bootstrap/cache
	@make fresh
clean:
	docker compose down --rmi all --volumes --remove-orphans
build:
	docker compose build --no-cache --force-rm
up:
	docker compose up -d
down:
	docker compose down
fresh:
	docker compose exec app php artisan migrate:fresh --seed
app:
	docker compose exec app bash
sql:
	docker compose exec db bash -c 'mysql -u $$MYSQL_USER -p$$MYSQL_PASSWORD $$MYSQL_DATABASE'
ps:
	docker compose ps
