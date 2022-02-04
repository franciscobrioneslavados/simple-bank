package token

import "time"

//Maker is an interface for manangin tokens
type Maker interface {
	// CreateToken creates a new token fro a specific username and duration
	CreateToken(username string, duration time.Duration) (string, error)

	// VerifyToken checks if the token is valid or not
	VerifyToken(token string) (*Payload, error)
}
