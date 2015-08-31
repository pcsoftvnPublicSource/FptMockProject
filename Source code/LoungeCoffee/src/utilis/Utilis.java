package utilis;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

public class Utilis {
	/**
	 * Format currency type as Vietnamese format
	 *
	 * @param currency
	 *            currency need to be formated
	 * @return String object that contain currency formatted
	 */
	public static String formatCurrency(double currency) {
		/*
		 * input pattern output 123456.789 ###,###.### 123,456.789 123456.789
		 * ###.## 123456.79 123.78 000000.000 000123.780 12345.67 $###,###.###
		 * $12,345.67 12345.67 \u00A5###,###.### ¥12,345.67
		 */

		Locale currentLocale = new Locale("vi", "VN");
		NumberFormat nf = NumberFormat.getNumberInstance(currentLocale);
		DecimalFormat df = (DecimalFormat) nf;
		df.applyPattern("###,###.###");
		String output = df.format(currency);
		return output;
	}

	/**
	 * Encode a string using MD5 method
	 * 
	 * @param source
	 *            source of string need to encode
	 * @return encoded string if success, empty string for otherwise
	 */
	public static String Md5Encode(String source) {
		MessageDigest md;
		String result = "";

		try {
			md = MessageDigest.getInstance("MD5");
			md.update(source.getBytes());

			byte byteData[] = md.digest();

			// convert the byte to hex format method 1
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}

			result = sb.toString();

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return result;

	}
}
