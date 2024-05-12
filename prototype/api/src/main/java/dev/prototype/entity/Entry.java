package dev.prototype.entity;

import java.io.Serializable;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@SuppressWarnings("serial")
public class Entry implements Serializable {

  @Id
  @GeneratedValue
  private Long id;

  @Column(name = "title", nullable = false)
  private String title;

  @Column(name = "type")
  private String type;

  public Entry() {}

  public Entry(String title, String type) {
    this.title = title;
    this.type = type;
  }

  @Override
  public int hashCode() {
    return (id != null ? id.hashCode() : 0);
  }

  @Override
  public boolean equals(Object obj) {
    return (obj instanceof Entry ? equals(id, obj) : false);
  }

  static boolean equals(Long id, Object obj) {
    var same = (Entry) obj;
    return (id != null ? id.equals(same.id) : same.id == null);
  }

  @Override
  public String toString() {
    return "dev.prototype.entity.Entry[id=" + id + "]";
  }

}
