#!/bin/zsh

# Install default databases for macOS
if [[ -v OMAKUB_FIRST_RUN_DBS ]]; then
	dbs=$OMAKUB_FIRST_RUN_DBS
else
	AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")
	dbs=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --height 5 --header "Select databases (runs in Docker)")
fi

if [[ -n "$dbs" ]]; then
	# Convert to array using zsh parameter expansion
	local db_array=("${(@f)dbs}")

	for db in "${db_array[@]}"; do
		# Skip empty lines and trim whitespace
		db=$(echo "$db" | xargs)
		if [[ -n "$db" ]]; then
			case $db in
			"MySQL")
				docker run -d --restart unless-stopped -p "127.0.0.1:3306:3306" --name=mysql8 -e MYSQL_ROOT_PASSWORD= -e MYSQL_ALLOW_EMPTY_PASSWORD=true mysql:8.4
				echo "✓ MySQL 8.4 container started on port 3306"
				;;
			"Redis")
				docker run -d --restart unless-stopped -p "127.0.0.1:6379:6379" --name=redis redis:7
				echo "✓ Redis 7 container started on port 6379"
				;;
			"PostgreSQL")
				docker run -d --restart unless-stopped -p "127.0.0.1:5432:5432" --name=postgres16 -e POSTGRES_HOST_AUTH_METHOD=trust postgres:16
				echo "✓ PostgreSQL 16 container started on port 5432"
				;;
			esac
		fi
	done

	echo ""
	echo "💡 Database connection info:"
	echo "   MySQL:      127.0.0.1:3306 (root user, no password)"
	echo "   Redis:      127.0.0.1:6379"
	echo "   PostgreSQL: 127.0.0.1:5432 (postgres user, no password)"
	echo ""
	echo "🐳 Manage containers:"
	echo "   List:    docker ps"
	echo "   Stop:    docker stop <container-name>"
	echo "   Start:   docker start <container-name>"
	echo "   Remove:  docker rm <container-name>"
fi
