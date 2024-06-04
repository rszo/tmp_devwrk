import BookmarkList from '@/components/BookmarkList'

export default function BookmarksPage() {
  return (
    <main className="p-6 max-w-xl mx-auto">
      <h1 className="text-2xl font-bold mb-4">📚 ブックマーク一覧</h1>
      <BookmarkList />
    </main>
  )
}
