// src/components/MemoCard.tsx
import React from 'react';
import { Memo } from '../types/memo';

interface MemoCardProps {
  memo: Memo;
  onEdit: (memo: Memo) => void;
  onArchiveToggle: (id: string) => void;
  onDelete: (id: string) => void;
}

const MemoCard: React.FC<MemoCardProps> = ({ memo, onEdit, onArchiveToggle, onDelete }) => {
  return (
    <div
      className="bg-white rounded-lg shadow-md p-4 mb-4 relative hover:shadow-lg transition-shadow duration-200"
      style={{ backgroundColor: memo.color || 'white' }}
    >
      {memo.title && <h3 className="text-lg font-semibold mb-2">{memo.title}</h3>}
      <p className="text-gray-700 whitespace-pre-wrap">{memo.content}</p>

      <div className="flex justify-end space-x-2 mt-4 opacity-0 group-hover:opacity-100 transition-opacity duration-200">
        <button
          onClick={() => onEdit(memo)}
          className="text-gray-500 hover:text-blue-600 p-1 rounded-full hover:bg-gray-100 transition-colors"
          title="編集"
        >
          {/* Edit Icon (例: Heroicons) */}
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"></path></svg>
        </button>
        <button
          onClick={() => onArchiveToggle(memo.id)}
          className="text-gray-500 hover:text-green-600 p-1 rounded-full hover:bg-gray-100 transition-colors"
          title={memo.isArchived ? 'アーカイブ解除' : 'アーカイブ'}
        >
          {/* Archive/Unarchive Icon (例: Heroicons) */}
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"></path></svg>
        </button>
        <button
          onClick={() => onDelete(memo.id)}
          className="text-gray-500 hover:text-red-600 p-1 rounded-full hover:bg-gray-100 transition-colors"
          title="削除"
        >
          {/* Delete Icon (例: Heroicons) */}
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10H5m0 0l1-2h4l1 2h4l1-2h4"></path></svg>
        </button>
      </div>
    </div>
  );
};

export default MemoCard;