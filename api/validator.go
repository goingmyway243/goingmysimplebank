package api

import "github.com/go-playground/validator/v10"

var validCurrency validator.Func = func(fieldLevel validator.FieldLevel) bool {
	if currency, ok := fieldLevel.Field().Interface().(string); ok {
		switch currency {
		case "USD", "EUR", "JPY", "VND":
			return true
		}
	}

	return false
}
