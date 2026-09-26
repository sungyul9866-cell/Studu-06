-- 쇼핑 리스트 항목 테이블
create table if not exists public.shopping_item (
  id bigint generated always as identity primary key,
  name text not null check (char_length(name) between 1 and 200),
  done boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.shopping_item enable row level security;

-- 로그인 기능이 없는 공개 쇼핑 리스트이므로 anon 역할에 CRUD를 허용한다
create policy "shopping_item_select" on public.shopping_item
  for select to anon, authenticated using (true);
create policy "shopping_item_insert" on public.shopping_item
  for insert to anon, authenticated with check (true);
create policy "shopping_item_update" on public.shopping_item
  for update to anon, authenticated using (true) with check (true);
create policy "shopping_item_delete" on public.shopping_item
  for delete to anon, authenticated using (true);

grant select, insert, update, delete on public.shopping_item to anon, authenticated;
