package application;
public class SimpleClass implements SimpleInterface {

	public void method(int a, SimpleClass c) {
		System.out.println("The actual invocation of the annotated method occurred.");
	}
	
	public void method(int a) {}
	
	public void someOtherMethod() {}

}
