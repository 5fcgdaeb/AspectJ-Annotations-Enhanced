package library;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;

public aspect AnnotationTools {

	public static boolean implementsAnnotation(String annotation, JoinPoint joinPoint) {
		
		Method invokedMethodOfInterface = findInvokedMethod(joinPoint);
		
		if(invokedMethodOfInterface == null) return false;
		
		return doesInvokedMethodContainAnnotation(invokedMethodOfInterface, annotation);

	}

	private static Method findInvokedMethod(JoinPoint joinPoint) {
		
		List<Method> allMethods = getMethodsOfAllInterfaces(joinPoint); 
		
		for(Method method: allMethods) {
			if(methodMatchesSignature(method,joinPoint.getSignature()))
				return method;
		}
		
		return null;
	}
	
	private static List<Method> getMethodsOfAllInterfaces(JoinPoint joinPoint) {
		
		if(isStaticMethod(joinPoint)) return new ArrayList<Method>();
		
		Class<?> classInHierarchy = joinPoint.getTarget().getClass();
		
		List<Method> allMethods = new ArrayList<Method>();
		
		while(classInHierarchy != null) {
			
			Class<?>[] implementedInterfaces = classInHierarchy.getInterfaces();	
			
			for(Class<?> implementedInterface : implementedInterfaces) {
				allMethods.addAll(Arrays.asList(implementedInterface.getMethods()));
			}
			classInHierarchy = classInHierarchy.getSuperclass();
		}
		
		return allMethods;
	}

	private static boolean methodMatchesSignature(Method method, Signature signature) {
		
		MethodComparer comparer = new MethodComparer(method);
		
		return comparer.hasSignature(signature);
		
	}
	
	private static boolean isStaticMethod(JoinPoint joinPoint) {
		return joinPoint.getTarget() == null;
	}

	private static boolean doesInvokedMethodContainAnnotation(Method invokedMethodOfInterface, String annotation) {
		
		MethodAnnotationChecker checker = new MethodAnnotationChecker(invokedMethodOfInterface);
		
		return checker.containsAnnotation(annotation);
	}	
}
