package application;
public class SimpleClass implements SimpleInterface {

	public void method(int a, SimpleClass c) {
		System.out.println("Actual implementation is called");
	}
	
	public void method(int a) {}
	
	public void someOtherMethod() {}

}
