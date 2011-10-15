package application;
import static library.AnnotationTools.*;

public aspect AnnotationAspect {
	
	pointcut importantMethodIsExecuted(): execution(public * application.*.*(..)) &&
							if(implementsAnnotation("@ImportantMethod()", thisJoinPoint));

	before(): importantMethodIsExecuted() {
		System.out.println("Pointcut works, annotated method invocation intercepted.");
	}
	
}
