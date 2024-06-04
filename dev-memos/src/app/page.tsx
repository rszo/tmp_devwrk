// src/app/page.tsx
'use client'; // Client Componentとしてマーク

import React, { useState, useEffect } from 'react';
import MemoCard from '../components/MemoCard';
import MemoForm from '../components/MemoForm';
import MemoInputArea from '../components/MemoInputArea';
import { Memo } from '../types/memo';

export default function Home() {
  const [memos, setMemos] = useState<Memo[]>([]);
  const [isFormOpen, setIsFormOpen] = useState(false);
  const [editingMemo, setEditingMemo] = useState<Memo | null>(null);

  // ローカルストレージからのデータ読み込み
  useEffect(() => {
    const storedMemos = localStorage.getItem('memos');
    if (storedMemos) {
      setMemos(JSON.parse(storedMemos));
    }
  }, []);

  // メモが変更されたらローカルストレージに保存
  useEffect(() => {
    localStorage.setItem('memos', JSON.stringify(memos));
  }, [memos]);

  const handleSaveMemo = (memo: Memo) => {
    if (memo.id) {
      // 既存メモの更新
      setMemos((prevMemos) =>
        prevMemos.map((m) => (m.id === memo.id ? { ...memo, updatedAt: Date.now() } : m))
      );
    } else {
      // 新規メモの追加
      setMemos((prevMemos) => [
        { ...memo, id: Date.now().toString(), createdAt: Date.now(), updatedAt: Date.now() },
        ...prevMemos, // 新しいメモを先頭に追加
      ]);
    }
    setIsFormOpen(false);
    setEditingMemo(null);
  };

  const handleEditMemo = (memo: Memo) => {
    setEditingMemo(memo);
    setIsFormOpen(true);
  };

  const handleDeleteMemo = (id: string) => {
    setMemos((prevMemos) => prevMemos.filter((memo) => memo.id !== id));
  };

  const handleArchiveToggle = (id: string) => {
    setMemos((prevMemos) =>
      prevMemos.map((memo) =>
        memo.id === id ? { ...memo, isArchived: !memo.isArchived, updatedAt: Date.now() } : memo
      )
    );
  };

  const activeMemos = memos.filter((memo) => !memo.isArchived);
  const archivedMemos = memos.filter((memo) => memo.isArchived);

  return (
    <div>
      <MemoInputArea onSave={handleSaveMemo} />

      <h2 className="text-2xl font-bold mb-4">メモ</h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
        {activeMemos.length === 0 ? (
          <p className="text-gray-600 col-span-full text-center">まだメモがありません。上記フォームからメモを作成しましょう。</p>
        ) : (
          activeMemos.map((memo) => (
            <MemoCard
              key={memo.id}
              memo={memo}
              onEdit={handleEditMemo}
              onArchiveToggle={handleArchiveToggle}
              onDelete={handleDeleteMemo}
            />
          ))
        )}
      </div>

      {archivedMemos.length > 0 && (
        <>
          <h2 className="text-2xl font-bold mt-8 mb-4">アーカイブ</h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
            {archivedMemos.map((memo) => (
              <MemoCard
                key={memo.id}
                memo={memo}
                onEdit={handleEditMemo}
                onArchiveToggle={handleArchiveToggle}
                onDelete={handleDeleteMemo}
              />
            ))}
          </div>
        </>
      )}

      <MemoForm
        isOpen={isFormOpen}
        onClose={() => setIsFormOpen(false)}
        onSave={handleSaveMemo}
        initialMemo={editingMemo}
      />
    </div>
  );
}