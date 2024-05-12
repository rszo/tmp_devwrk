package dev.prototype.webapi;

import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;
import dev.prototype.entity.Entry;
import dev.prototype.entity.Entry2;
import dev.prototype.entity.Entry3;
import jakarta.persistence.NoResultException;
import jakarta.ws.rs.FormParam;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("entry")
public class EntryResource {

  static final Logger LOGGER = Logger.getLogger(EntryResource.class.getName());

  @GET
  @Path("list")
  @Produces(MediaType.APPLICATION_JSON + "; charset=UTF-8")
  public Response list() {
    LOGGER.fine("on");

    List<Entry> list = null;

    var em = Fns.createEntityManager();
    try {
      String qlString = "SELECT t FROM Entry t";

      list = em.createQuery(qlString, Entry.class).getResultList();
      list.add(0, firstEntry());

    } catch (NoResultException e) {
      list = List.of(firstEntry());

    } finally {
      em.close();
    }

    return Response.ok(list).build();
  }

  @GET
  @Path("get2/{id}")
  @Produces(MediaType.APPLICATION_JSON + "; charset=UTF-8")
  public Response get2(@PathParam("id") final Long id) {
    LOGGER.fine("on");

    var em = Fns.createEntityManager();
    try {
      String qlString = String.join(" ", //
          "SELECT e2 FROM Entry2 e2", //
          "JOIN e2.entry e", //
          "WHERE e.id =", ":id");

      var result = em.createQuery(qlString, Entry2.class) //
          .setParameter("id", id) //
          .getSingleResult();

      return Response.ok(result).build();

    } finally {
      em.close();
    }
  }

  @GET
  @Path("get3/{id}")
  @Produces(MediaType.APPLICATION_JSON + "; charset=UTF-8")
  public Response get3(@PathParam("id") final Long id) {
    LOGGER.fine("on");

    var em = Fns.createEntityManager();
    try {
      String qlString = String.join(" ", //
          "SELECT e3 FROM Entry3 e3", //
          "JOIN e3.entry e", //
          "WHERE e.id =", ":id");

      var result = em.createQuery(qlString, Entry3.class) //
          .setParameter("id", id) //
          .getSingleResult();

      return Response.ok(result).build();

    } finally {
      em.close();
    }
  }

  @GET
  @Produces(MediaType.TEXT_PLAIN)
  public String getIt() {
    return "Hello, World!";
  }

  @POST
  @Path("add2")
  public String add2( //
      @FormParam("title") String title, //
      @FormParam("cmd") String cmd, //
      @FormParam("args") String args //
  ) {
    LOGGER.fine(Arrays.toString(new String[] {title, cmd, args}));

    var em = Fns.createEntityManager();
    try {
      em.getTransaction().begin();
      em.persist(new Entry2(title, cmd, args));
      em.getTransaction().commit();

    } catch (Exception e) {
      throw new WebApplicationException(e, 500);

    } finally {
      em.close();
    }

    return "done";
  }

  @POST
  @Path("add3")
  public String add3( //
      @FormParam("title") String title, //
      @FormParam("image") String image //
  ) {
    LOGGER.fine(Arrays.toString(new String[] {title, image}));

    var em = Fns.createEntityManager();
    try {
      em.getTransaction().begin();
      em.persist(new Entry3(title, image));
      em.getTransaction().commit();

    } catch (Exception e) {
      throw new WebApplicationException(e, 500);

    } finally {
      em.close();
    }

    return "done";
  }

  private static Entry firstEntry() {
    return new Entry("追加", "1");
  }

}
