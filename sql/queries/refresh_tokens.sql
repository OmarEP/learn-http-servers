-- name: CreateRefreshToken :one
INSERT INTO refresh_tokens
    (token, created_at, updated_at, user_id, expires_at, revoked_at)
VALUES(
        $1,
        NOW(),
        NOW(),
        $2,
        $3,
        NULL
)
RETURNING *;

-- name: GetUserFromRefreshToken :one
SELECT users.*
FROM users
    INNER JOIN refresh_tokens
    ON users.id = refresh_tokens.user_id
WHERE $1 = refresh_tokens.token
    AND revoked_at IS NULL
    AND expires_at > NOW();


-- name: RevokeRefreshToken :one 
UPDATE refresh_tokens
SET updated_at = NOW(), revoked_at = NOW()
WHERE token = $1
RETURNING *;