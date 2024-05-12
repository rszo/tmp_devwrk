package dev.prototype.webapi;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaQuery;

final class Fns {

  Fns() {}

  @SuppressWarnings("unchecked")
  static <T> TypedQuery<T> createQuery(EntityManager em, String name) {
    return (TypedQuery<T>) em.createNamedQuery(name);
  }

  static <T> CriteriaQuery<T> createCriteriaQuery(EntityManager em, Class<T> cls) {
    return em.getCriteriaBuilder().createQuery(cls);
  }

  static EntityManager createEntityManager() {
    return getEntityManagerFactory().createEntityManager();
  }

  static EntityManagerFactory getEntityManagerFactory() {
    return Persistence.createEntityManagerFactory("default");
  }

}
