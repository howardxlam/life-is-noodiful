package com.howard.restaurant.models;

import jakarta.validation.constraints.NotBlank;

public class CreditCard {
    
    @NotBlank(message="Credit card number is required!")
	private String cardNumber;
    
    @NotBlank(message="Expiration date is required!")
    private String expirationDate;
    
    @NotBlank(message="CVC is required!")
    private String cvc;
    
    private Long locationId;
    
    public Long getLocationId() {
		return locationId;
	}

	public void setLocationId(Long locationId) {
		this.locationId = locationId;
	}

	public CreditCard() {}
    
	public String getCardNumber() {
		return cardNumber;
	}
	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}
	public String getExpirationDate() {
		return expirationDate;
	}
	public void setExpirationDate(String expirationDate) {
		this.expirationDate = expirationDate;
	}
	public String getCvc() {
		return cvc;
	}
	public void setCvc(String cvc) {
		this.cvc = cvc;
	}

}
