package dev.prototype.webapi;

import static org.junit.Assert.assertEquals;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.test.JerseyTest;
import org.junit.Test;
import jakarta.ws.rs.core.Application;

public class EntryResourceTest extends JerseyTest {

  @Override
  protected Application configure() {
    return new ResourceConfig(EntryResource.class);
  }

  /**
   * Test to see that the message "Got it!" is sent in the response.
   */
  @Test
  public void testGetIt() {
    final String responseMsg = target().path("entry").request().get(String.class);

    assertEquals("Hello, World!", responseMsg);
  }

}
