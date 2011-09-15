import static library.AnnotationTools.*;

public aspect AnnotationAspect {
	
	pointcut importantMethodIsExecuted(): execution(public * SimpleInterface+.*(..)) && 
							if(containsAnnotation("@ImportantMethod()", thisJoinPoint));

	before(): importantMethodIsExecuted() {
		System.out.println("Important Method Pointcut match");
	}
	
	pointcut importantMethodIsExecuted2(): execution(@ImportantMethod * SimpleInterface+.*(..));
	
	before(): importantMethodIsExecuted2() {
		System.out.println("This cannot happen");
	}
	
	
}
