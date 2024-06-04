// src/types/memo.ts
export interface Memo {
  id: string;
  title: string;
  content: string;
  createdAt: number; // Unixタイムスタンプ
  updatedAt: number; // Unixタイムスタンプ
  isArchived: boolean;
  tags: string[]; // タグ機能を追加する場合
  color?: string; // 背景色を追加する場合
}