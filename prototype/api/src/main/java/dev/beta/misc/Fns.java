package dev.beta.misc;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class Fns {

  public static boolean isEmptyString(String value) {
    return value == null || value.isEmpty();
  }

  public static boolean deleteFile(String pathString) {
    return deleteFile(Paths.get(pathString));
  }

  public static boolean deleteFile(Path path) {
    try {
      return Files.deleteIfExists(path);

    } catch (IOException e) {
      return false;
    }
  }

  public static void sleep(long millis) {
    try {
      Thread.sleep(millis);

    } catch (InterruptedException e) {
    }
  }

  public static void traceln(String text) {
    System.out.println(text);
  }

  public static void tracef(String format, Object args) {
    System.out.printf(format, args);
  }

  public static void debugln(String text) {
    System.out.println(text);
  }

  public static void debugf(String format, Object args) {
    System.out.printf(format, args);
  }

  public static void errorln(String text) {
    System.err.println(text);
  }

  public static void errorf(String format, Object args) {
    System.err.printf(format, args);
  }

}
