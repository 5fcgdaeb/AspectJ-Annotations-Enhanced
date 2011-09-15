package library;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import org.aspectj.lang.Signature;

public class MethodFromSignature {

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
		
		int positionOfMethodNameStart = signature.indexOf(".");
		int positionOfMethodNameEnd = signature.indexOf("(");
		
		methodName = signature.substring(positionOfMethodNameStart + 1,
											positionOfMethodNameEnd);
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
