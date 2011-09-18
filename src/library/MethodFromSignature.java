package library;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import org.aspectj.lang.Signature;

public class MethodFromSignature {

	// Find the difference between the two
	/*Method from method is:  public abstract void application.SimpleInterface.method(int,application.SimpleClass)
	Method from signature is: void application.SimpleClass.method(int)
	 */
	private Class<?> returnType;
	private String methodName;
	private List<Class<?>> parameterTypes;
	
	public MethodFromSignature(Signature signature) {
		this(signature.toString());
	}
	
	public MethodFromSignature(String signature) {
		parseSignature(signature);
	}

	private void parseSignature(String signature) {
		parseReturnType(signature);
		parseMethodName(signature);
		parseParameterTypes(signature);
	}

	private void parseReturnType(String signature) {
		
		String[] splitBySpace = signature.split(" ");
		String returnTypeInString = splitBySpace[0];
		
		returnType = getClassByClassName(returnTypeInString);
		
	}

	private Class<?> getClassByClassName(String returnTypeInString) {
		try {
			return ClassLoader.getSystemClassLoader().loadClass(returnTypeInString);
		} 
		catch (ClassNotFoundException exception) {
			exception.printStackTrace();
			return null;
		}
	}
	
	private void parseMethodName(String signature) {
		
		String methodBeforeArguments = signature.substring(0, signature.indexOf("("));
		int positionOfMethodNameStart = methodBeforeArguments.lastIndexOf(".");
		
		methodName = methodBeforeArguments.substring(positionOfMethodNameStart + 1);
	}

	private void parseParameterTypes(String signature) {
		
		int positionOfParameterStart = signature.indexOf("(");
		int positionOfParameterEnd = signature.indexOf(")");
		
		String allParams = signature.substring(positionOfParameterStart + 1, 
												positionOfParameterEnd);
		
		String[] paramsInArray = allParams.split(",");
		List<Class<?>> parameters = new ArrayList<Class<?>>();
		
		for(String parameter : paramsInArray) {
			parameters.add(getClassByClassName(parameter));
		}
	}
	
	public Class<?> getReturnType() {
		return returnType;
	}

	public String getMethodName() {
		return methodName;
	}

	public List<Class<?>> getParameterTypes() {
		return parameterTypes;
	}
	
	public boolean matchesMethod(Method otherMethod) {
		return true;
	}
	
	
}
