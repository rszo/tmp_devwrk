package dev.prototype.entity;

import java.io.Serializable;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table
@Getter
@Setter
@SuppressWarnings("serial")
public class Entry3 implements Serializable {

  @Id
  @GeneratedValue
  private Long id;

  @OneToOne(cascade = CascadeType.PERSIST)
  @JoinColumn(name = "entry_id")
  private Entry entry;

  @Lob
  @Column(name = "image")
  private String image;

  public Entry3() {}

  public Entry3(String title, String image) {
    this.entry = new Entry(title, "3");
    this.image = image;
  }

  @Override
  public int hashCode() {
    return (id != null ? id.hashCode() : 0);
  }

  @Override
  public boolean equals(Object obj) {
    return (obj instanceof Entry3 ? equals(id, obj) : false);
  }

  static boolean equals(Long id, Object obj) {
    var same = (Entry3) obj;
    return (id != null ? id.equals(same.id) : same.id == null);
  }

  @Override
  public String toString() {
    return "dev.prototype.entity.Entry3[id=" + id + "]";
  }

}
