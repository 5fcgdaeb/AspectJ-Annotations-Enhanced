package library;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;


public aspect AnnotationTools {

	public static boolean containsAnnotation(String annotation, JoinPoint joinPoint) {
		
		Method invokedMethodOfInterface = findInvokedMethod(joinPoint);
		
		if(invokedMethodOfInterface == null) return false;
		
		return doesInvokedMethodContainAnnotation(invokedMethodOfInterface, annotation);

	}

	private static Method findInvokedMethod(JoinPoint joinPoint) {
		System.out.println(joinPoint.getSignature().toString());
		List<Method> allMethods = getMethodsOfAllInterfaces(joinPoint); 
		
		for(Method method: allMethods) {
			//System.out.println(method.getName());
			if(methodMatchesSignature(method,joinPoint.getSignature()))
				return method;
		}
		
		return null;
	}
	
	private static boolean methodMatchesSignature(Method method, Signature signature) {
		
		if(!method.getName().equals(signature.getName())) return false;
		
		return true;
		
	}

	private static List<Method> getMethodsOfAllInterfaces(JoinPoint joinPoint) {
		
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
	
	private static boolean doesInvokedMethodContainAnnotation(Method invokedMethodOfInterface, String annotation) {
		
		Annotation[] annotations = invokedMethodOfInterface.getAnnotations();
		
		for(Annotation ant : annotations) {
			//System.out.println(ant + "--" + annotation);
			if(ant.toString().equals(annotation))
				return true;
		}
		
		return false;
	}
}
