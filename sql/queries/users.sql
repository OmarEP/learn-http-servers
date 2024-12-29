-- name: CreateUser :one
INSERT INTO users
    (id, created, updated_at, email)
VALUES(
        gen_random_uuid(),
        NOW(),
        NOW(),
        $1
)
RETURNING *;