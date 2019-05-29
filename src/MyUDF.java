import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Base64;
import org.apache.pig.EvalFunc;
import org.apache.pig.data.Tuple;
import org.apache.pig.PigWarning;

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;


public class MyUDF extends EvalFunc<String> {

	@Override
	public String exec(Tuple input) throws IOException {
		if(input==null || input.size()<2 ){
			warn("invalid number of arguments to MyUDF",PigWarning.UDF_WARNING_1);
			return null;
		}
		try{
			String plainText=(String)input.get(0);
			String key=(String)input.get(1);
			String str="";
			try{
				str=encrypt(plainText,key.getBytes());
			}
			catch(NoSuchPaddingException e){
				str="NoSuchPaddingException";
				e.printStackTrace();
			}
			catch(IllegalBlockSizeException e){
				str="IllegalBlockSizeException";
				e.printStackTrace();
			}
			catch(BadPaddingException e){
				str="BadPaddingException";
				e.printStackTrace();
			}
			catch(InvalidKeyException e){
				str="InvalidKeyException";
				e.printStackTrace();
			}
			catch(NoSuchAlgorithmException e){
				str="NoSuchAlgorithmException";
				e.printStackTrace();
			}
			return str;
		}
		catch(NullPointerException e){
			warn(e.toString(),PigWarning.UDF_WARNING_2);
			return null;
		}
		catch(StringIndexOutOfBoundsException e){
			warn(e.toString(),PigWarning.UDF_WARNING_3);
			return null;
		}
		catch(ClassCastException e){
			warn(e.toString(),PigWarning.UDF_WARNING_4);
			return null;
		}
	}

	private String encrypt(String plainText, byte[] key) throws NoSuchAlgorithmException,InvalidKeyException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException {
		// Using ECB mode for simplicity in academic context
		// Note: In production, use CBC/GCM with proper IV management
		Cipher cipher=Cipher.getInstance("AES/ECB/PKCS5Padding");
		SecretKeySpec secretkey=new SecretKeySpec(key, "AES");
		cipher.init(Cipher.ENCRYPT_MODE,secretkey );
		String encryptedString=Base64.encodeBase64String(cipher.doFinal(plainText.getBytes()));
		return encryptedString.trim();
	}

}
// Dependencies: pig.jar, pig-0.12.0-cdh5.8.0.jar, commons-codec


