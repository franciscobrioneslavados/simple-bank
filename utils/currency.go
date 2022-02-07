package util

const (
	USD = "USD"
	EUR = "EUR"
	CLP = "CLP"
)

// IsSupportedCurrency returns true if the currency is supported
func IsSupportedCurrency(currency string) bool {
	switch currency {
	case USD, EUR, CLP:
		return true
	}
	return false
}
