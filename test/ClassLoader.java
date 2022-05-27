import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class ClassLoader {

  public static void main(String[] args) {
    String className = System.getenv().get("RUN_CLASS");
    try {
      callMain(className);
    }
    catch (Exception e) {
      System.err.println(e);
      System.err.println("Class name: " + className);
    }
  }

  static void callMain(String className)
      throws ClassNotFoundException, NoSuchMethodException, InvocationTargetException, IllegalAccessException {
    Class<?> clazz = Class.forName(className);
    Method m = clazz.getMethod("main", String[].class);
    m.invoke(null, (Object) null);
  }
}
