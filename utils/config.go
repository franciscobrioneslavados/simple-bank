package util

import (
	"time"

	"github.com/spf13/viper"
)

// COnfig stores all configurations of the application.
// The values are ready by viper from a config file or a environment variables.
type Config struct {
	DBDriver           string        `mapstructure:"DB_DRIVER"`
	DBSource           string        `mapstructure:"DB_SOURCE"`
	ServerAddress      string        `mapstructure:"SERVER_ADDRESS"`
	TokenSymmetricKey  string        `mapstructure:"TOKEN_SYMMETRIC_KEY"`
	AccesTokenDuration time.Duration `mapstructure:"ACCES_TOKEN_DURATION"`
}

// LoadConfig read configuration from file or environment variables
func LoadConfig(path string) (config Config, err error) {
	viper.AddConfigPath(path)
	viper.SetConfigName("app")
	viper.SetConfigType("env")

	viper.AutomaticEnv()

	err = viper.ReadInConfig()
	if err != nil {
		return
	}
	err = viper.Unmarshal(&config)
	return
}
