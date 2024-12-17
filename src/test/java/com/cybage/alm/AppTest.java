package com.cybage.alm;

import static org.junit.Assert.assertTrue;

import org.junit.Test;
import junit.framework.Assert;
/**
 * Unit test for simple App.
 */
public class AppTest {

	@Test
	public void testSum() {
		// Given
		App calculator = new App();
		// When
		int result = calculator.sum(2, 2);
		// Then
		if (result != 4) {   // if 2 + 2 != 4
			Assert.fail();
		}
	}

	@Test
	public void testMinus() {
		App calculator = new App();
		Assert.assertEquals(0, calculator.minus(2, 2));
	}

	@Test
	public void testDivide() {
		App calculator = new App();
		Assert.assertEquals(2, calculator.divide(6, 3));
	}

	@Test(expected = ArithmeticException.class)
	public void testDivideWillThrowExceptionWhenDivideOnZero() {
		App calculator = new App();
		calculator.divide(6, 0);
	}
	
	
	 @Test
	 public void testMultiply() {
	        App calculator = new App();
	        // Test cases with expected results
	        Assert.assertEquals(6, calculator.multiply(2, 3));  // 2 * 3 = 6
	        Assert.assertEquals(-6, calculator.multiply(-2, 3)); // -2 * 3 = -6
	        Assert.assertEquals(0, calculator.multiply(0, 5));  // 0 * 5 = 0
	        Assert.assertEquals(9, calculator.multiply(3, 3));  // 3 * 3 = 9
	    }
	
}