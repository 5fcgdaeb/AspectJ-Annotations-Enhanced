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
			if(methodMatchesSignature(method,joinPoint.getSignature()))
				return method;
		}
		
		return null;
	}
	
	private static boolean methodMatchesSignature(Method method, Signature signature) {
		
		//TODO: Use the class from library here
		if(!method.getName().equals(signature.getName())) return false;
		
		return true;
		
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
	
	private static boolean isStaticMethod(JoinPoint joinPoint) {
		return joinPoint.getTarget() == null;
	}

	private static boolean doesInvokedMethodContainAnnotation(Method invokedMethodOfInterface, String annotation) {
		
		Annotation[] annotations = invokedMethodOfInterface.getAnnotations();
		
		for(Annotation ant : annotations) {
			
			if(annotationMatches(ant,annotation)) return true;
			/*System.out.println(ant);
			System.out.println(ant.annotationType().toString());
			if(ant.toString().equals(annotation))
				return true;*/
		}
		
		return false;
	}

	private static boolean annotationMatches(Annotation antFromMethod, String antFromUser) {
		String justAnnotationNameFromUserInput = extractAnnotationNameFromUserInput(antFromUser);
		String justAnnotationNameFromMethod = extractAnnotationNameFromMethod(antFromMethod);
		
		return justAnnotationNameFromMethod.equalsIgnoreCase(justAnnotationNameFromUserInput);
	}

	private static String extractAnnotationNameFromMethod(Annotation antFromMethod) {
		int endOfAnnotationName = antFromMethod.toString().indexOf("(");
		String upToAnnotationName = antFromMethod.toString().substring(0,endOfAnnotationName);
		return upToAnnotationName.substring(upToAnnotationName.indexOf(".") + 1);
	}

	private static String extractAnnotationNameFromUserInput(String antFromUser) {
		int endOfAnnotationName = antFromUser.toString().indexOf("(");
		return antFromUser.substring(1,endOfAnnotationName);
	}
}
