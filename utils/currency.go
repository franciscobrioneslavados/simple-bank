package util

const (
	USD = "USD"
	EUR = "EUR"
	CLP = "CLP"
)

func IsSupportedCurrency(currency string) bool {
	switch currency {
	case USD, EUR, CLP:
		return true
	}
	return false
}
