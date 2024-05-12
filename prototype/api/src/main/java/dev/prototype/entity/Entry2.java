package dev.prototype.entity;

import java.io.Serializable;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table
@Getter
@Setter
@SuppressWarnings("serial")
public class Entry2 implements Serializable {

  @Id
  @GeneratedValue
  private Long id;

  @OneToOne(cascade = CascadeType.PERSIST)
  @JoinColumn(name = "entry_id")
  private Entry entry;

  @Column(name = "cmd")
  private String cmd;

  @Column(name = "args")
  private String args;

  public Entry2() {}

  public Entry2(String title, String cmd, String args) {
    this.entry = new Entry(title, "2");
    this.cmd = cmd;
    this.args = args;
  }

  @Override
  public int hashCode() {
    return (id != null ? id.hashCode() : 0);
  }

  @Override
  public boolean equals(Object obj) {
    return (obj instanceof Entry2 ? equals(id, obj) : false);
  }

  static boolean equals(Long id, Object obj) {
    var same = (Entry2) obj;
    return (id != null ? id.equals(same.id) : same.id == null);
  }

  @Override
  public String toString() {
    return "dev.prototype.entity.Entry2[id=" + id + "]";
  }

}
